import React from "react";
import Container from "react-bootstrap/Container";
import { Link } from "react-router-dom";

const App = () => (
  <div>
    <Container>
      <main role="main">
        <div className="py-4">
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
              <Link to="/signup">
                <button className="btn btn-primary">
                  Sign up as seller &raquo;
                </button>
              </Link>
            </p>
            <p>
              <Link to="/login">
                <button className="btn btn-primary">
                  Sign up as buyer &raquo;
                </button>
              </Link>
            </p>
          </div>
        </div>
      </main>
    </Container>
  </div>
);

export default App;
