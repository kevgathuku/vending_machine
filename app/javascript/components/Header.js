import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";

import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";

import { LinkContainer } from "react-router-bootstrap";

const Header = () => {
  const [userData, setUserData] = useState({
    username: "",
    role: null,
  });

  const location = useLocation();

  const checkUserData = () => {
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));

    if (userInfo?.username) {
      setUserData({
        username: userInfo.username,
        role: userInfo.role,
      });
    }

    if (!userInfo) {
      setUserData({
        username: "",
        role: null,
      });
    }
  };

  useEffect(() => {
    // On mount
    checkUserData();
  }, [userData.username]);

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
  });

  const { username, role } = userData;

  return (
    <Navbar bg="light" expand="lg">
      <Container>
        <LinkContainer to="/">
          <Navbar.Brand>Home</Navbar.Brand>
        </LinkContainer>
        <Navbar.Toggle />
        <Navbar.Collapse className="justify-content-end">
          <Navbar.Text>
            {username ? (
              <span>
                Signed in as: <a href="profile"> {`${username} (${role})`} </a>
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
