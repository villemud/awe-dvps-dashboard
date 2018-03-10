module Main exposing (..)

import Material


type alias Region =
    Int



-- The idea is to use the region to build the infrastructure map


type alias Model =
    { name : String
    , location : Region
    , mdl : Material.Model
    }
