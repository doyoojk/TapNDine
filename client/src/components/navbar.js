import React from "react";
import { Navbar, NavbarBrand } from "reactstrap";

export default props => {
  return (
    <div>
      <Navbar color="dark" light expand="md">
        <NavbarBrand
          className="nav-brand"
          onClick={_ => {
            props.setPage(0);
          }}
        >
          Tap'NDine
        </NavbarBrand>
      </Navbar>
    </div>
  );
};
