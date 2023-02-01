alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias x='exists() { [[ -d "$1" ]] }; if [[ -a Package.swift ]]; then open -a Xcode.app .; elif exists *.(xcworkspace|playground|xcodeproj); then open -a Xcode.app *.(xcworkspace|playground|xcodeproj); fi'

