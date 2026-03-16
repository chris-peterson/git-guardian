default: test

# run the unattended test suite
test:
    bash tests/test-git-guard.sh

# launch an interactive session with the plugin loaded and open the rules skill
rules:
    claude --plugin-dir . "/git-guardian:rules"
