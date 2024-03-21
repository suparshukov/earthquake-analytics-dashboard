import io
import pandas as pd
import time

from datetime import datetime, timedelta

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    
    earthquake_dtypes = {
        "latitude": float,
        "longitude": float,
        "depth": float,
        "mag": float,
        "nst": pd.Int64Dtype(),
        "gap": float,
        "dmin": float,
        "rms": float,
        "updated": float,
        "horizontalError": float,
        "depthError": float,
        "magError": float,
        "magNst": pd.Int64Dtype()
    }
    
    date_start = datetime.today().date() - timedelta(days=365)
    date_end = datetime.today().date()

    parse_dates = ['time', 'updated'] 
    
    current_date = date_start

    dfs = []
    while current_date <= date_end:
        try:
            start_time = current_date.strftime("%Y-%m-%d")
            end_time = (current_date + timedelta(days=1)).strftime("%Y-%m-%d")
            url = f"https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime={start_time}&endtime={end_time}"
            df = pd.read_csv(url, dtype=earthquake_dtypes, parse_dates=parse_dates)
            print(current_date, len(df), df['id'].nunique())
        except Exception as inst:
            print('error')
            continue
        current_date += timedelta(days=1)
        dfs.append(df)
        time.sleep(1)

    result_df = pd.concat(dfs)
    print("shape of the data: ", result_df.shape)
    
    return result_df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
