import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }

type alias Model =
    { count : Int
    , mdl :
        Material.Model
    }

model : Model
model =
    { count = 0
    , mdl =
        Material.model
    }

-- Action , Update
type Msg
    = Increase
     | Decrease
     | Reset
     | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )

update msg model =
  case msg of
    Increase ->
      ( { model | count = model.count  + 1 }
      , Cmd.none
      )

    Decrease ->
      ( { model | count = model.count - 1 }
      , Cmd.none
      )
    Reset ->
      ( { model | count = 0 }
      , Cmd.none
    )

    Mdl msg_ ->
        Material.update Mdl msg_ model



type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ text ("Current count: " ++ toString model.count)
          {- We construct the instances of the Button component that we need, one
             for the increase button, one for the reset button. First, the increase
             button. The first three arguments are:
               - A Msg constructor (`Mdl`), lifting Mdl messages to the Msg type.
               - An instance id (the `[0]`). Every component that uses the same model
                 collection (model.mdl in this file) must have a distinct instance id.
               - A reference to the elm-mdl model collection (`model.mdl`).
             Notice that we do not have to add fields for the increase and reset buttons
             separately to our model; and we did not have to add to our update messages
             to handle their internal events.
             Mdl components are configured with `Options`, similar to `Html.Attributes`.
             The `Options.onClick Increase` option instructs the button to send the `Increase`
             message when clicked. The `css ...` option adds CSS styling to the button.
             See `Material.Options` for details on options.
          -}
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Options.onClick Increase
            , css "margin" "0 24px"
            ]
            [ text "Increase" ]
        , Button.render Mdl
            [ 1 ]
            model.mdl
            [ Options.onClick Reset ]
            [ text "Reset" ]
        ]
        |> Material.Scheme.top
