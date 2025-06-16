import { useState } from 'react';
import { createActor, canisterId } from 'declarations/to_do_backend';
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent } from "@dfinity/agent";
import { BrowserRouter as Router, Route, Routes, useNavigate } from "react-router-dom";
import Index from './index';
import Tarefas from './tarefas';

function AppWrapper() {
  return (
    <Router>
      <App />
    </Router>
  );
}

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const navigate = useNavigate();

  async function login() {
    let authClient = await AuthClient.create();

    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSuccess: async () => {
        const identity = authClient.getIdentity();
        console.log("Principal:", identity.getPrincipal().toText());

        const agent = new HttpAgent({ identity });
        const actor = createActor(canisterId, { agent });

        await actor.get_principal_client();

        setIsLoggedIn(true);
        navigate("/tarefas");
      },
      windowOpenerFeatures: `
        left=${window.screen.width / 2 - 525 / 2},
        top=${window.screen.height / 2 - 705 / 2},
        toolbar=0,location=0,menubar=0,width=525,height=705
      `,
    });
  }

  return (
    <Routes>
      <Route path="/" element={<Index login={login} />} />
      <Route path="/tarefas" element={<Tarefas />} />
    </Routes>
  );
}

export default AppWrapper;
