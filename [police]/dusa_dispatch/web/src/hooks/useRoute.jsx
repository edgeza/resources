import { RouterContext } from './../providers/RouterProvider';
import { useContext } from 'react';

export const useRoute = () => {
    const { route, navigateTo } = useContext(RouterContext);
    return { route, navigateTo };
}