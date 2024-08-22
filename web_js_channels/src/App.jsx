import { useState, useEffect } from 'react'
import './App.css'

function App() {

  const [token, setToken] = useState('Token')

  useEffect(() => {
    // This function will be called by the Flutter app
    window.receiveToken = (receivedToken) => {
      console.log('Received token from Flutter:', receivedToken);
      setToken(receivedToken);
    };
  }, []);

  useEffect(() => {
    console.log('USe effect 2')
  }, []);

  return (
    <>
      <div>
        <h3>Hello, This is token</h3>
        <p>{token}</p>
      </div>
    </>
  )
}

export default App
