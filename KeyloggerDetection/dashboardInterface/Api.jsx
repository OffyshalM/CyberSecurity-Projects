
import axios from "axios";

const API_BASE_URL = "http://localhost:8080/alerts"; 

export const fetchAlerts = async () =>{

    try {
        const response = await axios.get (`${API_BASE_URL}/all`);
        return response.data;
    } catch (err){
        console.error("Error while fetching Alerts from backend:",e)
        return [];    
    }
}