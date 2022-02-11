
# declare an array called array and define 3 vales
profileNames=(
    'BibleGamifiedAppDevelopment.mobileprovision'
     )


# ------------------------------------------
# ------------------------------------------
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
#
# ⚠️⚠️ MAKE NO MODIFICATION BELOW THIS ⚠️⚠️
#
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
# ------------------------------------------
# ------------------------------------------


security list-keychains -s CICDIOS.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles/

for currentProfile in "${profileNames[@]}"
do

	# check if the profile file is .mobileprovision file and proceed further.
	if [[ $currentProfile == *.mobileprovision ]] ; then

	    if [ -f $currentProfile ] ; then
	      rm  ~/Library/MobileDevice/Provisioning\ Profiles/$currentProfile
	      echo $currentProfile " : is removed!"
	    fi

	    cp ./Profile/$currentProfile ~/Library/MobileDevice/Provisioning\ Profiles/
	    echo $currentProfile " : is added! "

    fi

done
