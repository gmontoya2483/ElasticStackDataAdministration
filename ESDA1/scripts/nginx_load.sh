if [ $# -eq 0 ]
then
  echo "No arguments supplied. Please, run:"
  echo "$0 <minimum | short | medium | long>"
  exit 1
fi

echo "Press [CTRL+C] to stop.."

i=1
while true
do
  if ! ((i % 100))
  then
    echo "$i requests"
    curl -s localhost/$1_delay -o /dev/null
  fi
  curl -s localhost/$1_delay -o /dev/null &
  ((i++))
done
