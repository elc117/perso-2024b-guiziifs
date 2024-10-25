{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import System.Random (randomRIO)
import Control.Monad.IO.Class (liftIO)
import qualified Data.Text.Lazy as TL
import Network.Wai.Middleware.Static (staticPolicy, addBase)
import Data.Text.Lazy (replace)
import System.IO (readFile)

-- Função para carregar os arquivos CSV
loadFile :: FilePath -> IO [String]
loadFile filePath = do
    content <- readFile filePath
    return (lines content)

-- Função que seleciona um item aleatoriamente
randomFile :: [String] -> IO String
randomFile items = do
    index <- randomRIO (0, length items - 1)
    return (items !! index)

-- Função para carregar templates HTML e substituir o placeholder
loadTemplate :: FilePath -> IO TL.Text
loadTemplate filePath = do
    content <- readFile filePath
    return (TL.pack content)

-- Função para substituir a recomendação no template
replacePlaceholder :: TL.Text -> String -> TL.Text
replacePlaceholder template recommendation = replace "{{recommendation}}" (TL.pack recommendation) template

main :: IO ()
main = do
    -- Define o nome dos arquivos CSV na pasta "data"
    let csvMovie = "data/filmes.csv"
    let csvSerie = "data/series.csv"
    let csvSong = "data/musicas.csv"

    -- Carrega os arquivos CSV
    movies <- loadFile csvMovie
    series <- loadFile csvSerie
    songs <- loadFile csvSong

    -- Carrega os templates HTML
    indexTemplate <- liftIO $ loadTemplate "templates/index.html"
    recommendationTemplate <- liftIO $ loadTemplate "templates/recommendation.html"

    -- Inicia o servidor Web
    scotty 3000 $ do
        middleware logStdoutDev
        middleware $ staticPolicy (addBase "static")  -- Servir arquivos estáticos da pasta "static"

        -- Página inicial com formulários
        get "/" $ do
            html indexTemplate

        -- Rota para obter uma música aleatória
        get "/random-song" $ do
            musicaIO <- liftIO $ randomFile songs
            let page = replacePlaceholder recommendationTemplate musicaIO
            html page

        -- Rota para obter um filme aleatório
        get "/random-movie" $ do
            filmeIO <- liftIO $ randomFile movies
            let page = replacePlaceholder recommendationTemplate filmeIO
            html page

        -- Rota para obter uma série aleatória
        get "/random-serie" $ do
            serieIO <- liftIO $ randomFile series
            let page = replacePlaceholder recommendationTemplate serieIO
            html page
