import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";

import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";

import { LinkContainer } from "react-router-bootstrap";

const Header = () => {
  const [userName, setUserName] = useState("");

  const location = useLocation();

  const checkUserData = () => {
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));

    if (userInfo?.username) {
      setUserName(userInfo.username);
    }

    if (!userInfo) {
      setUserName("");
    }
  };

  useEffect(() => {
    // On mount
    checkUserData();
  });

  useEffect(() => {
    // On navigate
    checkUserData();
  }, [location]);

  useEffect(() => {
    // On localstorage data change
    window.addEventListener("storage", checkUserData);

    return () => {
      window.removeEventListener("storage", checkUserData);
    };
  }, []);

  return (
    <Navbar bg="light" expand="lg">
      <Container>
        <LinkContainer to="/">
          <Navbar.Brand>Home</Navbar.Brand>
        </LinkContainer>
        <Navbar.Toggle />
        <Navbar.Collapse className="justify-content-end">
          <Navbar.Text>
            {userName ? (
              <span>
                Signed in as: <a href="profile"> {userName} </a>
              </span>
            ) : (
              <LinkContainer to="/login">
                <Nav.Link>Login</Nav.Link>
              </LinkContainer>
            )}
          </Navbar.Text>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

export default Header;
