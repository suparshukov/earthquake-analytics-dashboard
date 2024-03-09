if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    print("rows before filtering:", len(data))
    print("Preprocessing: rows with null latitude: ", 
        (data['latitude'].isna()).sum())
    print("Preprocessing: rows with null longitude: ", 
        (data['longitude'].isna()).sum())
    data = data[~data['latitude'].isna()]
    data = data[~data['longitude'].isna()]
    print("rows left:", len(data))

    data['event_date'] = data['time'].dt.date

    data.rename({
        'horizontalError': 'horizontal_error',
        'depthError': 'depth_error',
        'magError': 'mag_error',
        'magNst': 'mag_nst',
        'locationSource': 'location_source',
        'magSource': 'mag_source'
        },
        axis=1, inplace=True)

    return data