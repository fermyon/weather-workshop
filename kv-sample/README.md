# Kv Sample

A Spin application that uses Key-Value to serve HTML content.

## Building

The following command can be used to build the component:
```bash
spin build
```

### Running the App

```bash
spin up
```

Note: The key value store needs to be initialized with the data. If the application is deployed to FWF, then it cna be updated using the UI in fwf.sh or alternatively the app needs to be built with the post method handler. 

The app can be queryed using :
```bash
curl localhost;3000/cool-dry-breeze
```