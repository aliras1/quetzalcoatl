## Build

```
cd caff_parser
msbuild CAFFParser.sln
```

## Usage

```
CAFFParser.exe ./path/to/caff.caff
```

If the given resource was valid, a .GIF file is generated under the path `./path/to/caff.caff.gif`.
Meta-information about the .CAFF file is logged to the console.