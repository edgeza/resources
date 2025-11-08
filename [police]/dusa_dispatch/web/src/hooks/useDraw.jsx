import { DrawContext } from '../providers/DrawProivder';
import { useContext } from 'react';

export const useDraw = () => {
    const { saveData, map, screenShoter, screenShot, deleteData } = useContext(DrawContext);
    return { saveData, map, screenShoter, screenShot, deleteData };
}
