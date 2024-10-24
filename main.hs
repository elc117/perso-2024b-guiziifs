{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev, logStdout)
import System.Random (randomRIO, Random (random))
import Control.Monad.IO.Class (liftIO)
import qualified  Data.Text.Lazy as TL

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
        
        get "/" $ do
            html $
                "<html><body>" <>
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

        -- Rota para obter uma musica aleatorio
        get "/random-song" $ do
            musicaIO <- liftIO $ randomFile songs
            text $ "Musica Aleatoria: " <> TL.pack musicaIO 

        -- Rota para obter um filme aleatorio
        get "/random-movie" $ do
            filmeIO <- liftIO $ randomFile movies
            text $ "Filme Aleatório: " <> TL.pack filmeIO

        -- Rota para obter uma serie aleatória
        get "/random-serie" $ do
            serieIO <- liftIO $ randomFile series
            text $ "Serie Aleatória: " <> TL.pack serieIO

        