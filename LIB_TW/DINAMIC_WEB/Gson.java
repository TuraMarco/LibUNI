//	____________
//	|   GSON   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯
//  GSON è una libreria realizzata da Google finalizzata al PARSING/DEPARSING di oggetti
//  JSON.
//  Il suo funzionamento base è suddiviso nei seguenti punti:

//  Inizializzazione dell'oggetto Gson
Gson g = new Gson();

//  Serializzazione di un oggetto
Person p = new Person("Nome", "Cognome", anni);
String sJson = g.toJson(p);

//  Deserializzazione di un oggetto
Person p2 = g.fromJson(sJson, Person.class);

//  Serializzazione di una collection
Gson gson = new Gson();
Collection<Integer> ints = Lists.immutableList(1,2,3,4,5);
String json = gson.toJson(ints);  // ==> json is [1,2,3,4,5]

//  Deserializzazione di una collection
Type collectionType = new TypeToken<Collection<Integer>>(){}.getType();
Collection<Integer> ints2 = gson.fromJson(json, collectionType);
//  Gson è in grado di serializzare collection di oggetti arbitrari ma non di
//  deserializzarle, poichè non vi è alcun modo per il programmatore di specificare
//  il tipo dell'oggetto, (c'è modo ma è complicato)

//  Serializzare il "null"
Gson gson = new GsonBuilder().serializeNulls().create();

