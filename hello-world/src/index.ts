
// For AutoRouter documentation refer to https://itty.dev/itty-router/routers/autorouter
import { AutoRouter } from 'itty-router';

let router = AutoRouter();

// Route ordering matters, the first route that matches will be used
// Any route that does not return will be treated as a middleware
// Any unmatched route will return a 404
router
  .get('/', () => returnHTLM())

//@ts-ignore
addEventListener('fetch', (event: FetchEvent) => {
  event.respondWith(router.fetch(event.request));
});

function returnHTLM(): HtmlFragment {
  let fragment: HtmlFragment = {
    Html: '<div>Hello from Fermyon Wasm Functions!</div>'
  };

  return fragment;
};

class HtmlFragment {
  Html!: String;
}