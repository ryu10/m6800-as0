let vscode = require("vscode");
let path = require("path");
let os = require("os");

function activate(global) {
  console.log('Extension "m6800-as0" activated.');

  let disposable = vscode.commands.registerCommand(
    "m6800-as0.as0assemble",
    function() {
      let optionStr = "";
      let configuration = vscode.workspace.getConfiguration("m6800-as0");

      if (configuration.get("Listing")) {
        optionStr = optionStr + "l ";
      }

      if (configuration.get("NoListing")) {
        optionStr = optionStr + "nol ";
      }

      if (configuration.get("CrossReference")) {
        optionStr = optionStr + "cre ";
      }

      if (configuration.get("Symbol")) {
        optionStr = optionStr + "s ";
      }

      if (configuration.get("Cycle")) {
        optionStr = optionStr + "c ";
      }

      if (configuration.get("NoCycle")) {
        optionStr = optionStr + "noc ";
      }

      if (optionStr != "") {
        optionStr = "-" + optionStr;
      }

      let applicationPath = configuration.get("As0Path");
      let commandPath = applicationPath + path.sep + "as0";
      let listingExtension = configuration.get("ListingExtension"); 
      let srcPath = vscode.window.activeTextEditor.document.fileName;
      let srcDir = path.dirname(srcPath);
      let extName = path.extname(srcPath);
      let baseName = path.basename(srcPath, extName);
      let listingStr = "> " + baseName + listingExtension;

      if (extName.toLowerCase() == ".s" || extName.toLowerCase() == ".asm") {
        let platformStr = os.platform();
        if(platformStr == "win32"){ // windows10 + WSL + Ubuntu
          commandPath = commandPath.replace(/\\/g, "/");
          let commandArg = baseName + extName + " " + optionStr + " " + listingStr;
          let commandStr = "bash.exe -c '" + commandPath + " " + commandArg  +" '";
  
          const { exec } = require("child_process");
          let cp = exec(
              commandStr,
              { cwd: srcDir }
          );
          // show cp stderr
          cp.stderr.on('data', (data) => {
            vscode.window.showErrorMessage(`as0 stderr: ${data}`);
          });
          // show command
          vscode.window.showInformationMessage("as0: " + commandStr);
        }else{ // darwin / linux
          const { spawn } = require("child_process");
          let cp = spawn(
            commandPath,
            [baseName + extName, optionStr, listingStr],
            { cwd: srcDir, shell: true }
          );
          // show cp stderr
          cp.stderr.on('data', (data) => {
            vscode.window.showErrorMessage(`as0 stderr: ${data}`);
          });
          // show command
          vscode.window.showInformationMessage(
            "as0: " + commandPath + " " + baseName + extName + " " + optionStr + " " + listingStr
          );
        }
      }else{
        // show 'wrong source extension' error mesg
        vscode.window.showErrorMessage("as0: not a source file");
      }
    }
  );
}
exports.activate = activate;

function deactivate() {}
