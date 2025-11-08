import { LanguageContext } from './../providers/LanguageProvider';
import { useContext } from 'react';

export const useLanguage = () => {
    const { language, changeLanguage } = useContext(LanguageContext);
    return { language, changeLanguage };
}
