import System.Random (randomRIO)
import Data.Csv.Parser (csv)

-- funcao para carregar os filmes do arquivo
loadMovies :: FilePath -> IO [String]
loadMovies filePath = do
    content <- readFile filePath
    return (lines content)

-- funcao que seleciona um filme aleatoriamente
randomMovie :: [String] -> IO String
randomMovie movies = do
    index <- randomRIO (0, length movies - 1)
    return (movies !! index)

main :: IO()
main = do
    let csvFile = "filmes.csv"

    -- carrega os filmes
    movies <- loadMovies csvFile

    -- escolhe um filme aleatorio
    rMovie <- randomMovie movies

    -- printa na tela
    putStrLn $ "Filme aleatorio: " ++ rMovie
