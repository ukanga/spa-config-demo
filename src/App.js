import logo from './logo.svg';
import './App.css';

let AppConfig = {};

if (typeof window._env_ === 'undefined') {
    console.log("Global config not present.");
} else {
    if (typeof window._env_.AppConfig === 'undefined') {
        console.log("AppConfig not set");
    } else {
        console.log("Global config is set.");
        AppConfig = window._env_.AppConfig;
    }
}

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
            Hello, my code name is: <i>{AppConfig.CodeName}</i>.
        </p>
      </header>
    </div>
  );
}

export default App;
