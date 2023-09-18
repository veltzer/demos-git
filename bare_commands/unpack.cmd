mv "objects/pack" pack
for x in pack/*.pack
do
	echo "doing ${x}"
	git unpack-objects < $x
done
