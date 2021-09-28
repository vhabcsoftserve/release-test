# changes for 123
{
  title: "Example Connector 1",

  # API key authentication example. See more examples at https://docs.workato.com/developing-connectors/sdk/guides/authentication.html
  connection: {
    fields: [
      {
        name: "object",
        hint: "Type in the object you would like to test your connection with"
      }
    ],

    base_uri: lambda do
      puts 'getting base uri'

      "https://swapi.dev"
    end
  },
  test: lambda do |_connection|
    puts 'testing uri'
    get("https://swapi.dev/api/people/1")
  end,

  object_definitions: {
    #  Object definitions can be referenced by any input or output fields in actions/triggers.
    #  Use it to keep your code DRY. Possible arguments - connection, config_fields
    #  See more at https://docs.workato.com/developing-connectors/sdk/sdk-reference/object_definitions.html
  },

  actions: {
    get_person_by_id: {
      input_fields: lambda do
        [
          {
            name: 'id',
            label: 'Person ID',
            type: 'integer',
            optional: false
          }
        ]
      end,

      execute: lambda do |connection, input|
        puts 'fetching person'
        get("https://swapi.dev/api/people/#{input["id"]}/")
      end,

      output_fields: lambda do
        [
          {
            name: "name",
            label: "Person name",
            type: "string"
          },
          {
            name: "birth_year",
            label: "Birth year",
            type: "string"
          },
          {
            name: "eye_color",
            label: "Eye color",
            type: "string"
          },
          {
            name: "gender",
            label: "Gender",
            type: "string"
          },
          {
            name: "hair_color",
            label: "Hair color",
            type: "string"
          },
          {
            name: "height",
            label: "Height"
          },
          {
            name: "mass",
            label: "Weight"
          },
          {
            name: "films",
            label: "Films",
            type: "array",
            of: "string"
          },
          {
            name: "vehicles",
            label: "Vehicles",
            type: "array",
            of: "string"
          },
        ]
      end
    },
    get_film_by_url: {
      input_fields: lambda do
        [
          {
            name: 'url',
            label: 'Film URL',
            type: 'string',
            optional: false
          }
        ]
      end,

      execute: lambda do |connection, input|
        puts 'fetching films'
        get(input["url"])
      end,

      output_fields: lambda do
        [
          {
            name: "Title",
            label: "Film title",
            type: "string"
          },
          {
            name: "director",
            label: "Director",
            type: "string"
          },
          {
            name: "producer",
            label: "Producer",
            type: "string"
          },
          {
            name: "release_date",
            label: "Release Date",
            type: "string"
          },
          {
            name: "characters",
            label: "Characters",
            type: "array",
            of: "string"
          },
          {
            name: "planets",
            label: "Planets",
            type: "array",
            of: "string"
          },
        ]
      end
    },
    get_planet_by_url: {
      input_fields: lambda do
        [
          {
            name: 'url',
            label: 'Planet URL',
            type: 'string',
            optional: false
          }
        ]
      end,

      execute: lambda do |connection, input|
        puts 'fetching planet'
        get(input["url"])
      end,

      output_fields: lambda do
        [
          {
            name: "name",
            label: "Name",
            type: "string"
          },
          {
            name: "gravity",
            label: "Gravity",
            type: "string"
          },
          {
            name: "population",
            label: "Population",
            type: "string"
          }
        ]
      end
    }
  },

  triggers: {
    # Dynamic webhook example. Subscribes and unsubscribes webhooks programatically
    # see more at https://docs.workato.com/developing-connectors/sdk/guides/building-triggers/dynamic-webhook.html
  },

  pick_lists: {
    # Picklists can be referenced by inputs fields or object_definitions
    # possible arguements - connection
    # see more at https://docs.workato.com/developing-connectors/sdk/sdk-reference/picklists.html
  },

  # Reusable methods can be called from object_definitions, picklists or actions
  # See more at https://docs.workato.com/developing-connectors/sdk/sdk-reference/methods.html
  methods: {
  }
}

