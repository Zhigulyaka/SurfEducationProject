plists=(
"$SRCROOT/$DEPLOY_PRODUCT_NAME/Resources/Info.plist")

for plist in ${plists[*]}
do
    /usr/libexec/PlistBuddy -c "Delete :NSLocalNetworkUsageDescription" $plist
    /usr/libexec/PlistBuddy -c "Delete :NSBonjourServices" $plist
done

if [ "${CONFIGURATION}" = "Debug" ]; then
    
    for plist in ${plists[*]}
    do
        /usr/libexec/PlistBuddy -c "Add NSBonjourServices array" -c "Add NSBonjourServices: string _Proxyman._tcp" $plist
        /usr/libexec/PlistBuddy -c "Add :NSLocalNetworkUsageDescription string Atlantis would use Bonjour Service to discover Proxyman app from your local network." $plist
    done
fi

echo "----------------------------------------"
[[ "${CONFIGURATION}" = "Debug" ]] && echo "---------- 🧊 Atlantis enable ----------" || echo "---------- 🧊 Atlantis disable ---------"
echo "----------------------------------------"
