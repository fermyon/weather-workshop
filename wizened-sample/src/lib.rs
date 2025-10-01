use anyhow::Context;
use spin_sdk::http::{IntoResponse, Request, Response};
use spin_sdk::http_component;
use std::collections::HashMap;
use std::fs::File;
use std::sync::OnceLock;
use url::Url;

/// A simple Spin HTTP component.
#[http_component]
fn handle_wizened_sample(req: Request) -> anyhow::Result<impl IntoResponse> {
    if req.method().to_string().to_uppercase() != "GET" {
        return Ok(Response::builder()
            .status(405)
            .header("content-type", "text/plain")
            .body("Method Not Allowed")
            .build());
    }

    let content_map = CONTENT_MAP.get().context("Failed to get content map")?;

    let full_uri = req.uri();
    let parsed = Url::parse(full_uri)?;

    // Use the path as a key: "/" => "index", otherwise strip leading slash
    let path = parsed.path().trim_start_matches('/').to_lowercase();

    println!("Received request for path: {}", path);

    // Match against stored keys
    if let Some(body) = content_map.get(&path) {
        Ok(Response::builder()
            .status(200)
            .header("content-type", "text/html")
            .body(body.clone())
            .build())
    } else {
        Ok(Response::builder()
            .status(404)
            .header("content-type", "text/plain")
            .body("Not Found")
            .build())
    }
}

static CONTENT_MAP: OnceLock<HashMap<String, String>> = OnceLock::new();

#[export_name = "wizer.initialize"]
pub extern "C" fn init() {
    CONTENT_MAP.get_or_init(|| {
        let mut map = HashMap::new();
        let paths = std::fs::read_dir("data").unwrap();

        for path in paths {
            let path = path.unwrap().path();
            if path.extension().is_some_and(|ext| ext == "html") {
                let filename = path.file_stem().unwrap().to_str().unwrap().to_lowercase();
                let mut file = File::open(&path).unwrap();
                let mut contents = String::new();
                use std::io::Read;
                file.read_to_string(&mut contents).unwrap();
                println!("Loaded file: {} with length {}", filename, contents.len());
                map.insert(filename, contents);
            }
        }

        map
    });
}
