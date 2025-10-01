
// For AutoRouter documentation refer to https://itty.dev/itty-router/routers/autorouter
import { AutoRouter, IRequest } from 'itty-router';
import { openDefault } from "@spinframework/spin-kv";

let router = AutoRouter();

// Route ordering matters, the first route that matches will be used
// Any route that does not return will be treated as a middleware
// Any unmatched route will return a 404
router
  .get('/:key', (req: IRequest) => {
    let key = req.params.key;
    key = key.toLowerCase();

    let store = openDefault();
    let value = store.get(key);

    if (value === null) {
      return new Response(`Key ${key} not found`, { status: 404 });
    }

    return new Response(new TextDecoder().decode(value), {
      headers: {
        'Content-Type': 'text/html;charset=UTF-8',
      },
    });
  });

// For easy updating of the KV store, uncomment the below code and
// use a tool like curl or Postman to POST data to the KV store.
// This is simpler than uploading one file at a time in fwf.sh
// router.post('/:key', async (req: IRequest) => {
//   let key = req.params.key;
//   key = key.toLowerCase();
//   let value = await req.text();

//   let store = openDefault();
//   store.set(key, value);

//   return new Response(`Key ${key} set`, { status: 200 });
// });

//@ts-ignore
addEventListener('fetch', (event: FetchEvent) => {
  event.respondWith(router.fetch(event.request));
});

