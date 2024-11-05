# Use TailwindCSS at any location on the device
I created a little utility script that allow me to use TailwindCSS, wherever I am on my computer.

This utility can be run by 2 methods :
- minify : Result CSS is minified
- special : Result CSS doesn't include ```@base```

## Configuration
The utility should be in the same directory than the TailwindCSS's package.json file.<br>
You need to set two scripts into the package.json file :
- minify : ```npx tailwindcss -o public/output.css --minify```
- special : ```tailwindcss build -i ssrc/input.css -o public/output.css```

To use the "special" build script, you need to create a folder called 'ssrc' that will be used only by "special" build mode. In this folder, you should put the file "input.css", with the following content :
```
@tailwind components;
@tailwind utilities;
```

The minify build mode will use the basic "src" folder to compile. And the "input.css" file inside it, is the basic TailwindCSS file.
