import React from "react";

import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";

const Header = () => (
  <Navbar bg="light" expand="lg">
    <Container>
      <Navbar.Brand href="/">Vending Machine</Navbar.Brand>
      <Navbar.Toggle />
      <Navbar.Collapse className="justify-content-end">
        <Navbar.Text>
          {/* Signed in as: <a href="#login">Mark Otto</a> */}
          <Nav.Link href="#login">Login</Nav.Link>
        </Navbar.Text>
      </Navbar.Collapse>
    </Container>
  </Navbar>
);

export default Header;
