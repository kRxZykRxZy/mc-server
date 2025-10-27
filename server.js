import { spawn } from "child_process";
import readline from "readline";
import fs from "fs";

// Make sure eula.txt is accepted
if (!fs.existsSync("eula.txt")) {
  fs.writeFileSync("eula.txt", "eula=true\n");
}

// Persistent world folder (mounted volume in VPS)
const worldDir = "./world";
if (!fs.existsSync(worldDir)) fs.mkdirSync(worldDir);

console.log("Starting Minecraft server...");

const server = spawn("java", [
  "-Xmx2G", // Max memory
  "-Xms1G", // Initial memory
  "-jar",
  "server.jar",
  "nogui"
]);

// Log output
server.stdout.on("data", data => process.stdout.write(data.toString()));
server.stderr.on("data", data => process.stderr.write(data.toString()));
server.on("exit", code => console.log(`Server stopped (code ${code})`));

// Command line input → Minecraft console
const rl = readline.createInterface({ input: process.stdin });
rl.on("line", line => server.stdin.write(line.trim() + "\n"));
