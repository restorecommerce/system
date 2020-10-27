mkdir build
cd build
BUILD_HOME=$PWD
echo $BUILD_HOME

# ordering + catalog + fulfilllment + facade + indexing -> GitLab (newer), others need to be pulled from GitHub instead
# choices
choices=( 'restorecommerce/identity-srv' 'restorecommerce/notification-srv'
          'restorecommerce/scheduling-srv' 'restorecommerce/resource-srv'
          'restorecommerce/rendering-srv' 'restorecommerce/indexing-srv'
          'restorecommerce/access-control-srv' 'restorecommerce/ordering-srv'
          'restorecommerce/ostorage-srv' 'restorecommerce/catalog-srv'
          'restorecommerce/fulfillment-srv' 'restorecommerce/facade-srv')

build_all="all"

if [ $# != 0 ]
then
  arg1="$1"
  shift 1
  if [ "$build_all" == "$arg1" ]
  then
    echo "ok, let's build all images!"
    for choice in "${choices[@]}"; do
      echo "Choice #$(( ++i )): $choice"
      IFS=' /:' read -ra array <<< "$choice"
      echo "Repository name ${array[0]}"
      echo "MicroService name ${array[1]}"

      cd $BUILD_HOME
      if [ "${array[0]}" = "restorecommerce" ]; then
        if [ "${array[1]}" = "ordering-srv" -o "${array[1]}" = "catalog-srv" -o "${array[1]}" = "fulfillment-srv" -o "${array[1]}" = "facade-srv" -o "${array[1]}" = "indexing-srv" ]; then
          # services not yet on GitHub
          git clone --recursive ssh://git@gitlab.n-fuse.co:10022/restorecommerce/${array[1]}.git
        else
          git clone --recursive git@github.com:restorecommerce/${array[1]}.git
        fi          
      elif [ "${array[0]}" = "xingular" ]; then
        git clone --recursive ssh://git@gitlab.n-fuse.co:10022/xingular/${array[1]}.git
      fi
      chmod 600 ../rsa_key/id_rsa
      cp ../rsa_key/* ${array[1]}/
      cd ${array[1]}
      bash buildImage.bash
    done
  else
    echo "wrong command line argument passed!"
  fi
else
  echo "select the list of microservices for which the images need to be created: (ex: 1, 2, 3 or 1 2 3 etc)"
  select temp in "${choices[@]}"; do  # present numbered choices to user
    # Parse ,-separated numbers entered into an array.
    # Variable $REPLY contains whatever the user entered.
    IFS=', ' read -ra selChoices <<< "$REPLY"
    # Loop over all numbers entered.
    for choice in "${selChoices[@]}"; do
      # Validate the number entered.
      (( choice >= 1 && choice <= ${#choices[@]} )) || { echo "Invalid choice: $choice. Try again." >&2; continue 2; }
      # If valid, echo the choice and its number.
      echo "Choice #$(( ++i )): ${choices[choice-1]} ($choice)"
      echo "creating image: ${choices[choice-1]}"

      # check if its a restorecommerce or xingular image
      IFS=' /:' read -ra array <<< "${choices[choice-1]}"
      echo "Repository name ${array[0]}"
      echo "MicroService name ${array[1]}"

      cd $BUILD_HOME
      if [ "${array[0]}" = "restorecommerce" ]; then
        if [ "${array[1]}" = "ordering-srv" -o "${array[1]}" = "catalog-srv" -o "${array[1]}" = "fulfillment-srv" -o "${array[1]}" = "facade-srv" -o "${array[1]}" = "indexing-srv" ]; then
          # services not yet on GitHub
          git clone --recursive ssh://git@gitlab.n-fuse.co:10022/restorecommerce/${array[1]}.git
        else
          git clone --recursive git@github.com:restorecommerce/${array[1]}.git
        fi   
      elif [ "${array[0]}" = "xingular" ]; then
        git clone --recursive ssh://git@gitlab.n-fuse.co:10022/xingular/${array[1]}.git
      fi
      chmod 600 ../rsa_key/id_rsa
      cp ../rsa_key/* ${array[1]}/
      cd ${array[1]}
      bash buildImage.bash
    done
    # All choices are valid, exit the prompt.
    break
  done
fi

echo 'removing dangling images'
docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi -f
echo 'removed all the dangling images'
echo 'Images built successfully'

cd $BUILD_HOME

echo "Done."
