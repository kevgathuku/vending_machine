import React from "react";
import Container from "react-bootstrap/Container";

import Header from "./Header";

const App = () => (
  <div>
    <Header />
    <Container>
      <main role="main">
        <div className="jumbotron">
          <div className="col-sm-8 mx-auto">
            <h3>Welcome to the Vending Machine.</h3>
            <p>
              To add your products to the vending machine, please sign up as a
              seller
            </p>
            <p>
              To buy products from the vending machine, please sign up as a
              buyer
            </p>
            <p>
              <a className="btn btn-primary" href="#login" role="button">
                Sign up as seller &raquo;
              </a>
            </p>
            <p>
              <a className="btn btn-primary" href="#login" role="button">
                Sign up as buyer &raquo;
              </a>
            </p>
          </div>
        </div>
      </main>
    </Container>
  </div>
);

export default App;
