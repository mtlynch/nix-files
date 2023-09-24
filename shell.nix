{
  programs.bash = {
    shellInit = ''
      function git_sync_and_branch {
        local readonly TARGET_BRANCH="''$1"
        local readonly MAIN_BRANCH='master'

        git checkout "''${MAIN_BRANCH}" && \
          git pull origin "''${MAIN_BRANCH}" && \
          if [[ -n "''${TARGET_BRANCH}" ]]; then
            git checkout -b "''${TARGET_BRANCH}"
          fi
      }

      function git_commit_and_push {
        local readonly COMMIT_MESSAGE="''$1"

        git commit --message "''${COMMIT_MESSAGE}" && \
          git push
      }

      # Expand bash history tracking.
      shopt -s histappend
      export HISTSIZE=10000

      # Enable partial history search.
      "\e[A": history-search-backward
      "\e[B": history-search-forward
      '';
    shellAliases = {
      gau = "git add --update";
      ga = "git add --all";
      gaa = "git add --all";
      gags = "ga && gs";
      gs = "git status";
      gd = "git diff --cached";
      gb = "git branch -v --sort=committerdate | tail -n 10";
      gbb = "git checkout $(git branch --sort=-committerdate | grep -v \"^\\* \" | sed -n \"1 p\")";
      gbbb = "git checkout $(git branch --sort=-committerdate | grep -v \"^\\* \" | sed -n \"2 p\")";
      gc = "git commit --message";
      gcbm = "git_sync_and_branch";
      gcp = "git_commit_and_push";
      gco = "git checkout";
      gf = "git fetch";
      gl = "git log";
      gpom = "git pull origin master";
      gss = "git stash save";
      gsp = "git stash pop";
      gu = "git reset --soft HEAD~1";
      grc = "git rebase --continue";
      grm = "git rebase master";
      gp = "git push";
      gwip = "git commit --all --no-verify --message \"work in progress\"";
      au = "sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y";
      a = ". ./venv/bin/activate";
      td = "pushd $(mktemp -d)";
    };
  };
}
