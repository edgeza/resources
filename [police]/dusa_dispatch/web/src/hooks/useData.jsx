import { DataContext } from './../providers/DataProvider';
import { useContext } from 'react';

export const useData = () => {
    const {data , setData, uiData, setUiData} = useContext(DataContext);
    return { data, setData, uiData, setUiData };
}
