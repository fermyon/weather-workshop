# Wizened Sample

A Spin application that uses Wizer to load the content in during initialization for fast lookup at runtime. 

## Building

The following command can be used to build the component:
```bash
spin build
```

This will internally call the `build.sh` script and initialize the data from the `data` folder. 

### Running the App

```bash
spin up
```

The app can be queryed using :

```bash
curl localhost;3000/cool-dry-breeze
```