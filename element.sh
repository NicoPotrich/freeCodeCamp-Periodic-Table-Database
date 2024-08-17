PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
else
  ELEMENTS=$($PQSL "SELECT * FROM elements")
  echo $ELEMENTS
fi