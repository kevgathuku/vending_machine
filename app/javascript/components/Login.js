import React, { useState } from "react";
import { css } from "@emotion/react";
import { useNavigate } from "react-router-dom";
import isEmpty from "lodash.isempty";

import Button from "react-bootstrap/Button";
import Container from "react-bootstrap/Container";
import Form from "react-bootstrap/Form";

import FormErrors from "./FormErrors";
import { success, error } from "../helpers/notifications";

const formContainer = css`
  max-width: 330px;
`;

const validateForm = (userData) => {
  const errors = {};

  if (!userData.username.trim()) {
    errors.username = "Please enter a username";
  }

  if (!userData.password.trim()) {
    errors.password = "Please enter a password";
  }

  return errors;
};

const Login = () => {
  const [userData, setUserData] = useState({
    username: "",
    password: "",
  });
  const [formErrors, setFormErrors] = useState({});
  const [showFormErrors, setShowFormErrors] = useState(true);
  const navigate = useNavigate();

  const handleInputChange = (e) => {
    const { target } = e;
    const { name, value } = target;

    setUserData((prevState) => {
      return {
        ...prevState,
        [name]: value,
      };
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const errors = validateForm(userData);

    if (!isEmpty(errors)) {
      setFormErrors(errors);
      setShowFormErrors(true);
    } else {
      setShowFormErrors(false);
      console.log("Valid user data", userData);
      loginUser(userData);
    }
  };

  const loginUser = async (newUser) => {
    try {
      const response = await window.fetch("/authenticate", {
        method: "POST",
        body: JSON.stringify(newUser),
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      if (!response.ok) throw Error(response.statusText);

      const userResponse = await response.json();
      console.log("userResponse", userResponse);
      success("Login Successful!");

      localStorage.setItem(
        "userInfo",
        JSON.stringify({
          username: userResponse.user.username,
          role: userResponse.user.role,
          id: userResponse.user.id,
          token: userResponse.auth_token,
        })
      );
      navigate(`/`);
    } catch (err) {
      error("Something went wrong");
      console.error(err);
    }
  };

  return (
    <Container>
      {showFormErrors && (
        <FormErrors
          formErrors={formErrors}
          show={!isEmpty(formErrors)}
          dismiss={() => setShowFormErrors(false)}
        />
      )}
      <Form
        className="w-100 mx-auto py-5"
        css={formContainer}
        onSubmit={handleSubmit}
      >
        <Form.Group className="mb-3" controlId="username">
          <Form.Label>Username</Form.Label>
          <Form.Control
            name="username"
            type="text"
            placeholder="Enter username"
            onChange={handleInputChange}
          />
        </Form.Group>

        <Form.Group className="mb-3" controlId="password">
          <Form.Label>Password</Form.Label>
          <Form.Control
            name="password"
            type="password"
            placeholder="Password"
            onChange={handleInputChange}
          />
        </Form.Group>
        <Button variant="primary" type="submit">
          Submit
        </Button>
      </Form>
    </Container>
  );
};
export default Login;
