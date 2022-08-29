import React, { useState, useEffect } from "react";
import Container from "react-bootstrap/Container";
import { Link } from "react-router-dom";

const App = () => {
  const [userData, setUserData] = useState({
    username: "",
    role: null,
  });

  useEffect(() => {
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));

    if (userInfo?.username) {
      setUserData({
        username: userInfo.username,
        role: userInfo.role,
      });
    }
  }, [userData.username]);

  const notLoggedIn = () => !userData?.username;

  // TODO: Buyer -> show products that they can buy
  // TODO: Seller -> Show interface to add new products

  return (
    <div>
      <Container>
        <main role="main">
          <div className="py-4">
            <div className="col-sm-8 mx-auto">
              {userData?.username ? (
                <h3>{`Welcome to the Vending Machine, ${userData.username}`}</h3>
              ) : (
                <h3>Welcome to the Vending Machine</h3>
              )}
              {notLoggedIn() && (
                <>
                  <p>
                    To add your products to the vending machine, please sign up
                    as a seller
                  </p>
                  <p>
                    To buy products from the vending machine, please sign up as
                    a buyer
                  </p>
                  <p>
                    <Link to="/signup">
                      <button className="btn btn-primary">
                        Sign up as seller &raquo;
                      </button>
                    </Link>
                  </p>
                  <p>
                    <Link to="/signup">
                      <button className="btn btn-primary">
                        Sign up as buyer &raquo;
                      </button>
                    </Link>
                  </p>
                </>
              )}
            </div>
          </div>
        </main>
      </Container>
    </div>
  );
};

export default App;
