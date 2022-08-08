import React from "react";
import { css } from "@emotion/react";

import Button from "react-bootstrap/Button";
import Container from "react-bootstrap/Container";
import Form from "react-bootstrap/Form";

const formContainer = css`
  max-width: 330px;
`;

const SignUp = () => (
  <Container>
    <Form className="w-100 mx-auto py-5" css={formContainer}>
      <Form.Group className="mb-3" controlId="username">
        <Form.Label>Username</Form.Label>
        <Form.Control type="email" placeholder="Enter username" />
      </Form.Group>

      <Form.Group className="mb-3" controlId="password">
        <Form.Label>Password</Form.Label>
        <Form.Control type="password" placeholder="Password" />
      </Form.Group>

      <Form.Group className="mb-3" controlId="passwordConfirm">
        <Form.Label>Password</Form.Label>
        <Form.Control type="password" placeholder="Password" />
      </Form.Group>

      <Form.Group className="mb-3" controlId="role">
        <Form.Select aria-label="Default select example">
          <option>Select a role</option>
          <option value="0">Buyer</option>
          <option value="1">Seller</option>
        </Form.Select>
      </Form.Group>

      <Button variant="primary" type="submit">
        Submit
      </Button>
    </Form>
  </Container>
);
export default SignUp;
