import React, { useState } from "react";
import isEmpty from "lodash.isempty";
import Alert from "react-bootstrap/Alert";

const FormErrors = ({ formErrors, show, dismiss }) => {
  if (isEmpty(formErrors)) {
    return null;
  }

  if (show) {
    return (
      <Alert variant="danger" onClose={dismiss} dismissible>
        <Alert.Heading>
          The following errors prohibited the event from being saved:
        </Alert.Heading>
        <ul>
          {Object.values(formErrors).map((formError) => (
            <li key={formError}>{formError}</li>
          ))}
        </ul>
      </Alert>
    );
  }
};

export default FormErrors;
