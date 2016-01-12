# Show all branches in a git repository
alias gitkall='for b in "`git branch`"; do echo "$b"; done | tr -d "*" | xargs gitk'

# Alfred workflow management
alias workflowManagement='awm'
