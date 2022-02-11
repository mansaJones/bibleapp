
# declare all your Certificate Name in this array.
certificateNames=(
    'BibleGamifiedApp_Apple_Development.p12'
     )


# declare all your Certificate Password in this array. Please make sure to follow the order.
certificatePasswords=(
    'BibleGamifiedApp'
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

# get length of a certificateNames
arraylengthName=${#certificateNames[@]}

# get length of a certificateNames
arraylengthPassword=${#certificatePasswords[@]}


# make sure the length of Certificate Name and Password is the same.
if (( $arraylengthName == $arraylengthPassword ))
then

    # use for loop to read all values and indexes
	for (( i=0; i<${arraylengthName}; i++ ));
	do

		# get the certifiacte name from the array index
		certificateName="${certificateNames[$i]}"

		# get the certifiacte password from the array index
		certificatePassword="${certificatePasswords[$i]}"

		# printing the index - name - password
		# echo $i " / " ${arraylengthName} " : " $certificateName " : " $certificateName

		# check if the certificate file is .p12 file and proceed further.
		if [[ $certificateName == *.p12 ]] ; then

  			# import certificate to keychain
			security import ./Profile/$certificateName -k ~/Library/Keychains/CICDIOS.keychain -P \
			$certificatePassword -A

	      	echo $certificateName " : is added to keychain! "

	    fi

	done

fi

# --------------------------------------------------
# PLEASE DO NOT CHNAGE ANY CODE
# --------------------------------------------------
security set-key-partition-list -S apple-tool:,apple:,codesign: -s \
  -k indianic ~/Library/Keychains/CICDIOS.keychain
