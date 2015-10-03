initinstall pip sudo easy_install pip

# jedi is for python autocompletion
# epc is a bridge between python and elisp
## above are prerequisites for Emacs company-jedi
for mod in 'jedi' 'epc'; do
    python -c "import $mod" 2>/dev/null
    if [[ "$?" != "0" ]]; then
        echo "$mod not installed. Installing ..."
        sudo pip install "$mod"
    fi
done
