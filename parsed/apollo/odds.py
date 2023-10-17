import pandas as pd
from sklearn.metrics import brier_score_loss

def performance(df):
    actuals = []
    expected = []
    for i, row in df.iterrows():
        pinny_home = row['PSH'] if row.get('PSH') else row['B365H']
        pinny_draw = row['PSD'] if row.get('PSD') else row['B365D']
        pinny_away = row['PSA'] if row.get('PSA') else row['B365A']
        result = row['FTR']
        home_win = 1 if result == "H" else 0 
        draw = 1 if result == "D" else 0 
        away_win = 1 if result == "A" else 0 

        actuals.append(home_win)
        expected.append(1 / pinny_home)
        actuals.append(draw)
        expected.append(1 / pinny_draw)
        actuals.append(away_win)
        expected.append(1 / pinny_away)
    return brier_score_loss(actuals, expected)

if __name__ == "__main__":
    df = pd.read_csv("https://football-data.co.uk/mmz4281/1112/E0.csv")
    df1 = pd.read_csv("https://football-data.co.uk/mmz4281/1213/E0.csv")
    df2 = pd.read_csv("https://football-data.co.uk/mmz4281/1314/E0.csv")
    ##df3 = pd.read_csv("https://football-data.co.uk/mmz4281/1415/E0.csv")
    df4 = pd.read_csv("https://football-data.co.uk/mmz4281/1516/E0.csv")
    df5 = pd.read_csv("https://football-data.co.uk/mmz4281/1617/E0.csv")
    df6 = pd.read_csv("https://football-data.co.uk/mmz4281/1718/E0.csv")
    df7 = pd.read_csv("https://football-data.co.uk/mmz4281/1819/E0.csv")
    df8 = pd.read_csv("https://football-data.co.uk/mmz4281/1920/E0.csv")
    df9 = pd.read_csv("https://football-data.co.uk/mmz4281/2021/E0.csv")
    df10 = pd.read_csv("https://football-data.co.uk/mmz4281/2122/E0.csv")
    df11 = pd.read_csv("https://football-data.co.uk/mmz4281/2223/E0.csv")

    print(f"2012: {performance(df)}")
    print(f"2013: {performance(df1)}")
    print(f"2014: {performance(df2)}")
    ##print(f"2015: {performance(df3)}")
    print(f"2016: {performance(df4)}")
    print(f"2017: {performance(df5)}")
    print(f"2018: {performance(df6)}")
    print(f"2019: {performance(df7)}")
    print(f"2020: {performance(df8)}")
    print(f"2021: {performance(df9)}")
    print(f"2022: {performance(df10)}")
    print(f"2023: {performance(df11)}")
