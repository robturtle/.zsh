# Show all branches in a git repository
alias gitkall='gitk `for b in $(git branch); do echo "$b"; done | tr -d "*" | xargs` --'

# Alfred workflow management
alias workflowManagement='awm'
