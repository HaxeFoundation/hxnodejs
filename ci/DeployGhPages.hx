import Sys.*;
import Utils.*;
import Config.*;
using StringTools;

class DeployGhPages {
    static function main():Void {
        var root = getCwd();

        if (remote == null) {
            println('GHP_REMOTE is not set, skip deploy.');
            return;
        }

        // TravisCI by default clones repositories to a depth of 50 commits.
        // We need a full clone inorder to do git operations.
        runCommand("git", ["fetch", "--unshallow"]);

        var sha = commandOutput("git", ["rev-parse", "HEAD"]).trim();

        setCwd(htmlDir);
        runCommand("git", ["init"]);
        if (username != null)
            runCommand("git", ["config", "--local", "user.name", username]);
        if (email != null)
            runCommand("git", ["config", "--local", "user.email", email]);
        runCommand("git", ["remote", "add", "local", root]);
        runCommand("git", ["remote", "add", "remote", remote]);
        runCommand("git", ["fetch", "--all"]);
        runCommand("git", ["checkout", "--orphan", branch]);
        if (commandOutput("git", ["ls-remote", "--heads", "local", branch]).trim() != "") {
            runCommand("git", ["reset", "--soft", 'local/${branch}']);
        }
        if (commandOutput("git", ["ls-remote", "--heads", "remote", branch]).trim() != "") {
            runCommand("git", ["reset", "--soft", 'remote/${branch}']);
        }
        runCommand("git", ["add", "--all"]);
        runCommand("git", ["commit", "--allow-empty", "--quiet", "-m", 'deploy for ${sha}']);
        runCommand("git", ["push", "local", branch]);

        setCwd(root);
        runCommand("git", ["push", remote, branch]);
    }
}