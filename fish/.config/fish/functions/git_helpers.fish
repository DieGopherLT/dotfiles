# ~/.config/fish/functions/git_helpers.fish

function pushale
    set LocalBranch $argv[1]
    
    if test -z "$LocalBranch"
        git push
    else
        git push -u origin "$LocalBranch"
    end
end

function pulele
    set LocalBranch $argv[1]
    
    if test -z "$LocalBranch"
        git pull
    else
        git pull -u origin "$LocalBranch"
    end
end

function commit
    if test "$argv[1]" = "-a"
        git commit -a
    else
        git commit
    end
end

function newbranch
    if test -z "$argv[1]"
        echo "Usage: branch <branch_name>"
        return 1
    end
    
    git checkout -b "$argv[1]"
end

function git_config
    git config user.name "Diego López torres"
    git config user.email "diego@diegopher.dev"
end