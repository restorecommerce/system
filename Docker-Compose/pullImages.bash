echo "Login to registry.n-fuse.co"
docker login registry.n-fuse.co

microservices=( 'restorecommerce/identity-srv' 'restorecommerce/notification-srv'
          'restorecommerce/resource-srv' 'restorecommerce/scheduling-srv'
          'restorecommerce/rendering-srv' 'restorecommerce/indexing-srv'
          'restorecommerce/access-control-srv' 'restorecommerce/ordering-srv'
          'restorecommerce/ostorage-srv' 'restorecommerce/catalog-srv')

build_all="all"

len=${#microservices[@]}
echo "LEN $len"
for (( i=$len; i>=0; i-- ));
do
  echo ${microservices[$i]}
done


if [ $# != 0 ]
then
  arg1="$1"
  shift 1
  if [ "$build_all" == "$arg1" ]
  then
    echo "Pulling all microservice images"

    for (( i=$len; i>=0; i-- ));
      do
      # array[0] - repository type (xingular | restorecommerce), array[1] - microservice name
      IFS=' /:' read -ra array <<< "${microservices[$i]}"
      docker pull registry.n-fuse.co/${array[0]}/${array[1]}:latest
    done
  else
    echo "wrong command line argument passed"
  fi
else
  echo "select the list of microservices to be pushed to registry: (ex: 1, 2, 3 or 1 2 3 etc)"
  select temp in "${microservices[@]}"; do  # present numbered microservices to user
  # Parse ,-separated numbers entered into an array.
  # Variable $REPLY contains whatever the user entered.
  IFS=', ' read -ra selmicroservices <<<"$REPLY"
  # Loop over all numbers entered.
  for choice in "${selmicroservices[@]}"; do
    # Validate the number entered.
    (( choice >= 1 && choice <= ${#microservices[@]} )) || { echo "Invalid choice: $choice. Try again." >&2; continue 2; }
    # If valid, echo the choice and its number.
    echo "Choice #$(( ++i )): ${microservices[choice-1]} ($choice)"
    echo "pulling image from registry: ${microservices[choice-1]}"

    IFS=' /:' read -ra array <<< "${microservices[choice - 1]}"
    echo "Repository name ${array[0]}"
    echo "MicroService name ${array[1]}"

    docker pull registry.n-fuse.co/${array[0]}/${array[1]}:latest
    # fi
    # done
  done
  # All microservices are valid, exit the prompt.
  break
done
fi

echo "Done"
