PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
else
  # Consultar la base de datos
  RESULT=$(
            $PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type 
                   FROM elements 
                   INNER JOIN properties USING (atomic_number) 
                   INNER JOIN types USING (type_id) 
                   WHERE atomic_number::TEXT = '$1' OR symbol = '$1' OR name = '$1';"
            )

  # Mostrar los resultados
  if [[ -z $RESULT ]]; then
    echo "I could not find that element in the database."
  else
    echo "$RESULT" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi

