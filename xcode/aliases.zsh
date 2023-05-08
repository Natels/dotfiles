exists() { [[ -d "$1" ]] }
alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias xc='if [[ -a Package.swift ]]; then open -a Xcode.app .; elif exists *.(xcworkspace|xcodeproj|playground); then open -a Xcode.app *.(xcworkspace|playground|xcodeproj); fi'
alias studio='open -a Android\ Studio'
