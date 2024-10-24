{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev, logStdout)
import System.Random (randomRIO, Random (random))
import Control.Monad.IO.Class (liftIO)
import qualified  Data.Text.Lazy as TL
import Network.Wai.Middleware.Static (staticPolicy, addBase)

-- funcao para carregar os filmes do arquivo
loadFile :: FilePath -> IO [String]
loadFile filePath = do
    content <- readFile filePath
    return (lines content)

-- funcao que seleciona um filme aleatoriamente
randomFile :: [String] -> IO String
randomFile movies = do
    index <- randomRIO (0, length movies - 1)
    return (movies !! index)

main :: IO()
main = do
    -- define o nome dos arquivos
    let csvMovie = "filmes.csv"
    let csvSerie = "series.csv"
    let csvSong = "musicas.csv"

    -- carrega os arquivos
    movies <- loadFile csvMovie
    series <- loadFile csvSerie
    songs <- loadFile csvSong

    -- inicia servidor Web
    scotty 3000 $ do
        middleware logStdoutDev
        middleware $ staticPolicy (addBase "static")
        
        get "/" $ do
            html $
                "<html><head>" <>
                "<link rel='stylesheet' type='text/css' href='/style.css'>"<>
                "</head><body>" <>
                "<h1>Escolha uma recomendação: </h1>" <> 
                "<form action='/random-movie' method ='get'>" <>
                "<button type='submit'>Recomendar um filme</button>" <>
                "</form>" <>
                "<form action='/random-song' method ='get'>" <>
                "<button type='submit'>Recomendar uma Musica</button>" <>
                "</form>" <>
                "<form action='/random-serie' method ='get'>" <>
                "<button type='submit'>Recomendar uma Serie</button>" <>
                "</form>" <>
                "</body></html>"


        -- Rota para obter uma música aleatória
        get "/random-song" $ do
            musicaIO <- liftIO $ randomFile songs
            html $
                "<html><head>" <>
                "<link rel='stylesheet' type='text/css' href='/style.css'>" <>
                "</head><body>" <>
                "<div class='recommendation-container'>" <>
                "<h3>Música Recomendada: " <> TL.pack musicaIO <> "</h3>" <>
                "<a href='/'>Voltar</a>" <>
                "</div></body></html>"

        -- Rota para obter um filme aleatório
        get "/random-movie" $ do
            filmeIO <- liftIO $ randomFile movies
            html $
                "<html><head>" <>
                "<link rel='stylesheet' type='text/css' href='/style.css'>" <>
                "</head><body>" <>
                "<div class='recommendation-container'>" <>
                "<h3>Filme Recomendado: " <> TL.pack filmeIO <> "</h3>" <>
                "<a href='/'>Voltar</a>" <>
                "</div></body></html>"

        -- Rota para obter uma série aleatória
        get "/random-serie" $ do
            serieIO <- liftIO $ randomFile series
            html $
                "<html><head>" <>
                "<link rel='stylesheet' type='text/css' href='/style.css'>" <>
                "</head><body>" <>
                "<div class='recommendation-container'>" <>
                "<h3>Série Recomendada: " <> TL.pack serieIO <> "</h3>" <>
                "<a href='/'>Voltar</a>" <>
                "</div></body></html>"